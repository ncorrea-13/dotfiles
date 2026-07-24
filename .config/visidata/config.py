# ~/.config/visidata/config.py
from visidata import vd

vd.themes["tokyonight"] = dict(
    color_default="189",
    color_default_hdr="bold 111",
    color_bottom_hdr="underline 189",
    color_current_row="bold 189",
    color_current_col="bold 111",
    color_current_hdr="bold 111",
    color_column_sep="60",
    color_key_col="bold 141",
    color_hidden_col="237",
    color_selected_row="179",
    color_note_pending="bold 179",
    color_note_type="60",
    color_note_row="210",
    color_menu="234 on 111",
    color_menu_active="bold 234 on 141",
    color_menu_spec="234 on 150",
    color_menu_help="234 on 111",
    color_status="bold 189",
    color_error="bold 210",
    color_warning="179",
)

options.theme = "tokyonight"
options.quitguard = True
options.disp_date_fmt = "%Y-%m-%d"
