package cl.cc6909.ebm.leeconleo;

import android.app.Dialog;
import android.content.Context;
import android.graphics.Color;
import android.view.Gravity;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.TextView;

public class FeedbackDialog extends Dialog {

    private TextView tv;
    private Context context;

    public void setGoodFeedback(){
        tv.setText(context.getText(R.string.good_feedback));
        tv.setTextColor(Color.GREEN);
    }

    public void setBadFeedback(){
        tv.setText(context.getText(R.string.bad_feedback));
        tv.setTextColor(Color.RED);
    }
    public FeedbackDialog(Context context) {
        super(context, R.style.Theme_Transparent);
        this.context = context;
        WindowManager.LayoutParams wlmp = getWindow().getAttributes();
        wlmp.gravity = Gravity.CENTER_HORIZONTAL;
        getWindow().setAttributes(wlmp);
        setTitle(null);
        setCancelable(false);
        setOnCancelListener(null);
        LinearLayout layout = new LinearLayout(context);
        layout.setOrientation(LinearLayout.VERTICAL);
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        tv = new TextView(context);
        tv.setTextSize(200);
        layout.addView(tv, params);
        addContentView(layout, params);
    }
}