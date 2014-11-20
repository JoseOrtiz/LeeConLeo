package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.content.DialogInterface;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.style.ForegroundColorSpan;
import android.view.View;
import android.widget.TextView;

import cl.cc6909.ebm.leeconleo.R;

public class IntroductionActivity extends Activity implements View.OnClickListener{
    String letter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_introduction);
        letter = getIntent().getStringExtra("letter");
        Typeface tf = Typeface.createFromAsset(getAssets(),"fonts/little_days.ttf");
        TextView uppercaseHandwritten = (TextView) findViewById(R.id.uppercase_handwritten);
        Spannable word = new SpannableString(capitalizeFirstLetter(letter));
        word.setSpan(new ForegroundColorSpan(Color.RED), 0, 1, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
        word.setSpan(new ForegroundColorSpan(Color.BLUE),1,letter.length(),Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
        uppercaseHandwritten.setText(word);
        uppercaseHandwritten.setTypeface(tf);
        TextView lowercaseHandwritten= (TextView) findViewById(R.id.lowercase_handwritten);
        lowercaseHandwritten.setText(letter.toLowerCase());
        lowercaseHandwritten.setTypeface(tf);
        lowercaseHandwritten.setTextColor(Color.BLUE);
        TextView uppercasePrinting = (TextView) findViewById(R.id.uppercase_printing_letter);
        uppercasePrinting.setText(word);
        TextView lowercasePrinting= (TextView) findViewById(R.id.lowercase_printing_letter);
        lowercasePrinting.setText(letter.toLowerCase());
        lowercasePrinting.setTextColor(Color.BLUE);

        findViewById(R.id.back_button).setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()){
            case R.id.back_button:
                finish();
                break;
        }
    }

    private String capitalizeFirstLetter(String string){
        return string.substring(0, 1).toUpperCase() + string.substring(1);
    }
}
