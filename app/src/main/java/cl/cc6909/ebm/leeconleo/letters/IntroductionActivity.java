package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.widget.TextView;

import cl.cc6909.ebm.leeconleo.R;

public class IntroductionActivity extends Activity {
    String letter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_introduction);
        letter = getIntent().getStringExtra("letter");
        Typeface tf = Typeface.createFromAsset(getAssets(),"fonts/little_days.ttf");
        TextView uppercaseHandwritten = (TextView) findViewById(R.id.uppercase_handwritten);
        uppercaseHandwritten.setText(letter.toUpperCase());
        uppercaseHandwritten.setTypeface(tf);
        uppercaseHandwritten.setTextColor(Color.RED);
        TextView lowercaseHandwritten= (TextView) findViewById(R.id.lowercase_handwritten);
        lowercaseHandwritten.setText(letter.toLowerCase());
        lowercaseHandwritten.setTypeface(tf);
        lowercaseHandwritten.setTextColor(Color.BLUE);
        TextView uppercasePrinting = (TextView) findViewById(R.id.uppercase_printing_letter);
        uppercasePrinting.setText(letter.toUpperCase());
        uppercasePrinting.setTextColor(Color.RED);
        TextView lowercasePrinting= (TextView) findViewById(R.id.lowercase_printing_letter);
        lowercasePrinting.setText(letter.toLowerCase());
        lowercasePrinting.setTextColor(Color.BLUE);
    }
}
