/*
 * Copyright (C) 2024 Vladimir Vaskov
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 * 
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public sealed class FoldyD.Folder : Object {

    public string folder_id { get; construct; }

    public string[] apps { get; set; }

    public string[] excluded_apps { get; set; }

    public string[] categories { get; set; }

    public string name { get; set; }

    public bool translate { get; set; }

    public bool should_fix_categories { private get; construct; default = false; }

    Settings settings;

    public Folder (string folder_id) {
        Object (folder_id: folder_id);
    }

    public Folder.with_categories_fix (string folder_id) {
        Object (folder_id: folder_id, should_fix_categories: true);
    }

    construct {
        apps = Foldy.Folder.get_folder_apps (folder_id);
        excluded_apps = Foldy.Folder.get_folder_excluded_apps (folder_id);
        categories = Foldy.Folder.get_folder_categories (folder_id);
        name = Foldy.Folder.get_folder_name (folder_id);
        translate = Foldy.Folder.get_folder_translate (folder_id);

        settings = Foldy.Folder.get_folder_settings (folder_id);

        settings.changed["apps"].connect (refresh_apps);
        settings.changed["excluded-apps"].connect (refresh_excluded_apps);
        settings.changed["categories"].connect (refresh_categories);

        if (should_fix_categories) {
            var new_apps = new Gee.ArrayList<string> ();
            new_apps.add_all_array (apps);

            foreach (string category in categories) {
                foreach (string app_id in get_app_ids_by_category (category)) {
                    if (!(app_id in new_apps) && !(app_id in excluded_apps)) {
                        new_apps.add (app_id);
                    }
                }
            }

            update ();
        }
    }

    void refresh_apps () {
        var new_apps = Foldy.Folder.get_folder_apps (folder_id);

        var apps_to_remove = new Gee.ArrayList<string> ();
        var apps_to_add = new Gee.ArrayList<string> ();

        foreach (string app_id in apps) {
            if (!(app_id in new_apps)) {
                apps_to_remove.add (app_id);
            }
        }

        foreach (string new_app_id in new_apps) {
            if (!(new_app_id in apps)) {
                apps_to_add.add (new_app_id);
            }
        }

        foreach (string app_id in apps_to_remove) {
            if (app_id in get_app_ids_by_category (string category))
        }
    }

    void refresh_excluded_apps () {
        excluded_apps = Foldy.Folder.get_folder_excluded_apps (folder_id);
    }

    void refresh_categories () {
        categories = Foldy.Folder.get_folder_categories (folder_id);
    }

    void update () {
        Foldy.Folder.set_folder_name (folder_id, name);
        Foldy.Folder.set_folder_translate (folder_id, translate);
        Foldy.Folder.set_folder_apps (folder_id, apps);
        Foldy.Folder.set_folder_excluded_apps (folder_id, excluded_apps);
        Foldy.Folder.set_folder_categories (folder_id, categories);
    }
}
