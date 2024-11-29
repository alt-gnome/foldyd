/* Copyright 2024 Rirusha
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-only
 */

namespace FoldyD {
    string[] get_categories_by_app_id (string app_id) {
        var categories = new Array<string> ();

        var desktop = new DesktopAppInfo (app_id);
        var raw_categories = desktop.get_categories ().split (";");

        foreach (var raw_category in raw_categories) {
            if (raw_category.length > 0) {
                categories.append_val (raw_category);
            }
        }

        return categories.data;
    }

    string[] get_app_ids_by_category (string category) {
        var app_ids = new Array<string> ();

        foreach (AppInfo app_info in AppInfo.get_all ()) {
            string app_id = app_info.get_id ();

            if (category in get_categories_by_app_id (app_id)) {
                app_ids.append_val (app_id);
            }
        }

        return app_ids.data;
    }
}
