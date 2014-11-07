package cl.cc6909.ebm.leeconleo.letters;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.PorterDuff;
import android.support.annotation.NonNull;
import android.util.AttributeSet;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import java.util.ArrayList;
import java.util.Vector;

public class WrapView extends View {
    private Context context;
    private Path mPath;
    private Paint mPaint;
    private Bitmap mBitmap;
    private Canvas mCanvas;
    private Paint mBitmapPaint;
    private ArrayList<Path> paths = new ArrayList<Path>();
    private Vector<Float> xAxis, yAxis;

    public WrapView(Context context) {
        super(context);
        init(context);
    }

    public WrapView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context);
    }

    public WrapView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init(context);
    }

    public Vector<Float> getXAxis(){
        return xAxis;
    }
    public Vector<Float> getYAxis(){
        return yAxis;
    }
    private void init(Context c){
        context=c;
        xAxis = new Vector<Float>();
        yAxis = new Vector<Float>();
        mPath = new Path();
        paths.add(mPath);
        mBitmapPaint = new Paint(Paint.DITHER_FLAG);

        mPaint = new Paint();
        mPaint.setAntiAlias(true);
        mPaint.setDither(true);
        mPaint.setColor(Color.RED);
        mPaint.setStyle(Paint.Style.STROKE);
        mPaint.setStrokeJoin(Paint.Join.ROUND);
        mPaint.setStrokeCap(Paint.Cap.ROUND);
        mPaint.setStrokeWidth(10);
    }

    @Override
    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        super.onSizeChanged(w, h, oldw, oldh);

        mBitmap = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888);
        mCanvas = new Canvas(mBitmap);

    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);

        canvas.drawBitmap( mBitmap, 0, 0, mBitmapPaint);

        for(Path p: paths){
            canvas.drawPath(p,mPaint);
        }
    }

    private float mX, mY;
    private static final float TOUCH_TOLERANCE = 4;

    private void touch_start(float x, float y) {
        mPath.reset();
        mPath.moveTo(x, y);
        mX = x;
        mY = y;
        xAxis.clear();
        yAxis.clear();
        xAxis.add(mX);
        yAxis.add(mY);
    }
    private void touch_move(float x, float y) {
        float dx = Math.abs(x - mX);
        float dy = Math.abs(y - mY);
        if (dx >= TOUCH_TOLERANCE || dy >= TOUCH_TOLERANCE) {
            mPath.quadTo(mX, mY, (x + mX)/2, (y + mY)/2);
            mX = x;
            mY = y;
            xAxis.add(mX);
            yAxis.add(mY);
        }
    }
    private void touch_up() {
        mPath.lineTo(mX, mY);
        WrapActivity wrapActivity = (WrapActivity) context;
        if(wrapActivity.checkAnswer()){
            mCanvas.drawPath(mPath,  mPaint);
            mPath = new Path();
            paths.add(mPath);
        } else{
            mPath.reset();
            invalidate();
        }
    }

    @Override
    public boolean onTouchEvent(@NonNull MotionEvent event) {
        float x = event.getX();
        float y = event.getY();

        switch (event.getAction()) {
            case MotionEvent.ACTION_DOWN:
                touch_start(x, y);
                invalidate();
                break;
            case MotionEvent.ACTION_MOVE:
                touch_move(x, y);
                invalidate();
                break;
            case MotionEvent.ACTION_UP:
                touch_up();
                invalidate();
                break;
        }
        return true;
    }

    public void clearCanvas() {
        paths.clear();
        mPath.reset();
        paths.add(mPath);
        mCanvas.drawColor(Color.TRANSPARENT, PorterDuff.Mode.CLEAR);
        invalidate();
    }
}
