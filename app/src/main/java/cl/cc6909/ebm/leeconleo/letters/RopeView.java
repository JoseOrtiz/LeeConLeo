package cl.cc6909.ebm.leeconleo.letters;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.util.AttributeSet;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;

import cl.cc6909.ebm.leeconleo.R;
import cl.cc6909.ebm.leeconleo.Vector2D;

public class RopeView extends View{
    private float xPos, yPos;
    private Bitmap rope;
    private int height;

    public RopeView(Context context) {
        super(context);
        init();
    }

    public RopeView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    public RopeView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init();
    }

    private void init(){
        rope = BitmapFactory.decodeResource(getResources(), R.drawable.rope);
    }

    public void setData(int height){
        this.height = height;
        xPos = rope.getWidth();
        yPos = (height - rope.getHeight())/2;
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        float canvasx = (float) canvas.getWidth();
        float canvasy = (float) canvas.getHeight();
        float width = (float) rope.getWidth();
        float height = (float) rope.getHeight();
        Vector2D start = new Vector2D(0,(this.height - height)/2);
        Vector2D end = new Vector2D(xPos,yPos);
        double distance = Vector2D.distance(start, end);
        float scaleWidth = (float) (distance/width);
        Matrix matrix = new Matrix();
        matrix.postScale(scaleWidth,1f);
        Vector2D aux = Vector2D.subtract(end, start);
        float angle = (float) (Math.atan2(aux.getY(), aux.getX()) * 180 / Math.PI);
        matrix.postRotate(angle);
        matrix.postTranslate(width/2, -height / 2); // Centers image

        float boardPosX = 0;
        float boardPosY = (this.height - height) / 2;
        if(angle<0 || angle>180) {
            boardPosY -= Math.abs(Math.sin(angle * Math.PI / 180) * distance);
        }

        Bitmap bitmap = Bitmap.createBitmap(rope, 0, 0, (int) width, (int) height, matrix, true);
        matrix.reset();
        matrix.postTranslate(boardPosX, boardPosY);
        canvas.drawBitmap(bitmap, matrix, null);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event){
        xPos = event.getX();
        yPos = event.getY();
        invalidate();
        return super.onTouchEvent(event);
    }
}
