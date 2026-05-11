draw_healthbar(20, 40, 220, 60, (hp / max_hp) * 100, c_black, c_red, c_lime, 0, true, true);

draw_healthbar(0, 0, display_get_gui_width(), 20, (xp / next_xp) * 100, c_black, c_aqua, c_aqua, 0, true, true);

draw_set_halign(fa_center);
draw_text_transformed(display_get_gui_width()/2, 20, $"Level: {level}", 2, 2, 0);