using Toybox.Application as App;
import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Attention;
import Toybox.Math;
import Toybox.System;

class LapCounterView extends WatchUi.DataField {

    var add_lap;
    var lap_counter;

    function initialize() {
        DataField.initialize();

        // Countdown mode
        if (App.getApp().getProperty("countdown") == 1) {
            add_lap = -1;
        }
        else {
            add_lap = 1;
        }

        // Gets starting lap from user
        lap_counter = App.getApp().getProperty("lap_counter");

    }

    function onLayout(dc as Dc) as Void {
        var obscurityFlags = DataField.getObscurityFlags();

        // If not full screen
        if (obscurityFlags != 15) {
            View.setLayout(Rez.Layouts.SmallLayout(dc));
            var labelView = View.findDrawableById("label") as Text;
            labelView.locY = labelView.locY - 32;
            var valueView = View.findDrawableById("value") as Text;
            valueView.locY = valueView.locY + 25;

        } else {
            View.setLayout(Rez.Layouts.MainLayout(dc));
            var labelView = View.findDrawableById("label") as Text;
            labelView.locY = labelView.locY - 32;
            var valueView = View.findDrawableById("value") as Text;
            valueView.locY = valueView.locY + 25;
        }

        (View.findDrawableById("label") as Text).setText(Rez.Strings.label);
    }

    // Function called lap button is pressed. Resets timer
    function onTimerLap() as Void {
        lap_counter += add_lap;
    }

    function onUpdate(dc as Dc) as Void {
        // Set the background color
        (View.findDrawableById("Background") as Text).setColor(getBackgroundColor());

        // Set the foreground color and value
        var value = View.findDrawableById("value") as Text;
        if (getBackgroundColor() == Graphics.COLOR_BLACK) {
            value.setColor(Graphics.COLOR_WHITE);
        } else {
            value.setColor(Graphics.COLOR_BLACK);
        }
         
        value.setText(lap_counter.toString());

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

}
