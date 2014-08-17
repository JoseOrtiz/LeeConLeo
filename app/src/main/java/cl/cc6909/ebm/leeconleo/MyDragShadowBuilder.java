package cl.cc6909.ebm.leeconleo;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Point;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.view.View;

public class MyDragShadowBuilder extends View.DragShadowBuilder {

    private static Drawable shadow;
    private Bitmap image;

    public MyDragShadowBuilder(View v, Bitmap image) {
        super(v);
        shadow = new ColorDrawable(R.drawable.adventurer);
        this.image = image;
    }

    @Override
    public void onProvideShadowMetrics (Point size, Point touch){
        size.x = image.getWidth();
        size.y = image.getHeight();
        touch.x = size.x;
        touch.y = size.y;
    }
    @Override
    public void onDrawShadow(Canvas canvas) {
        canvas.drawBitmap(image, 0, 0, null);
    }
}