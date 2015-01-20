package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.support.annotation.NonNull;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;

import cl.cc6909.ebm.leeconleo.R;
import cl.cc6909.ebm.leeconleo.Vector2D;

public class RopeView extends View{
    private Vector2D position;
    private Bitmap rope, harness;
    private int height, hookWidth;
    private boolean touching;
    private Matrix matrix;
    private Vector2D start;
    private JoinActivity join;

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
        harness = BitmapFactory.decodeResource(getResources(), R.drawable.harness);
        hookWidth= BitmapFactory.decodeResource(getResources(), R.drawable.hook).getWidth();
        position = new Vector2D(50,rope.getHeight()/2);
        touching = false;
        matrix = new Matrix();
    }

    public void setData(int height){
        this.height = height;
        position = new Vector2D(rope.getWidth(),(height - rope.getHeight())/2);
        start = new Vector2D(0,(this.height - rope.getHeight())/2);
    }

    public void restart(){
        position = new Vector2D(rope.getWidth(),(height - rope.getHeight())/2);
        invalidate();
    }

    public void setActivity(JoinActivity join){
        this.join = join;
    }


    @Override
    protected void onDraw(Canvas canvas) {
        //super.onDraw(canvas);
        float width = (float) rope.getWidth();
        float height = (float) rope.getHeight();
        Vector2D end = position;
        double distance = Vector2D.distance(start, end);
        float scaleWidth = (float) (distance/width);
        matrix.reset();
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
        canvas.drawBitmap(harness,end.getX()-1,end.getY()-1-harness.getHeight()/2,null);
    }

    @Override
    public boolean onTouchEvent(@NonNull MotionEvent event){
        int action = event.getActionMasked();
        switch (action) {
            case MotionEvent.ACTION_DOWN: {
                Vector2D touch = new Vector2D(event.getX(), event.getY());
                if(Vector2D.distance(position,touch)<100){
                    position = touch;
                    touching=true;
                }
                break;
            }
            case MotionEvent.ACTION_MOVE: {
                if(touching){
                    position = new Vector2D(event.getX(), event.getY());
                }
                break;
            }
            case MotionEvent.ACTION_UP: {
                touching = false;
                int limit = getWidth() - hookWidth - harness.getWidth()/2;
                if(position.getX()> limit){
                    int answer = (int) (position.getY() * 4 / height);
                    if(answer>3) answer=3;
                    if(answer<0) answer=0;
                    position = new Vector2D(limit,answer*height/4+height/8);
                    join.checkAnswer(answer);
                }
                break;
            }
        }
        invalidate();
        return true;
    }
}
