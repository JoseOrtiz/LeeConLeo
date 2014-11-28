package cl.cc6909.ebm.leeconleo.letters;

import android.content.Context;
import android.graphics.PixelFormat;
import android.opengl.GLSurfaceView;
import android.util.AttributeSet;
import android.util.Log;
import android.view.MotionEvent;

import cl.cc6909.ebm.leeconleo.Vector2D;

public class StitchGLSurfaceView extends GLSurfaceView{

    private Context mContext;
    private StitchRenderer mRenderer;
    private int dimension;
    private int[] stitchPointer;
    public StitchGLSurfaceView(Context context) {
        super(context);
        init(context);
    }

    public StitchGLSurfaceView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context);
    }

    public void setDimension(int dim){
        dimension=dim;
    }

    private void init(Context context) {
        mContext = context;
        stitchPointer = new int[2];
        mRenderer = new StitchRenderer(mContext);
        //setZOrderOnTop(true);
        setEGLConfigChooser(8, 8, 8, 8, 16, 0);
        getHolder().setFormat(PixelFormat.RGBA_8888);
        setEGLContextClientVersion(2);
        setRenderer(mRenderer);
        setRenderMode(GLSurfaceView.RENDERMODE_WHEN_DIRTY);
        requestFocus();
    }

    private float adjustCoordinate(float coord){
        return 2*coord/dimension-1;
    }

    @Override
    public boolean onTouchEvent(MotionEvent event){
        int pointerIndex = event.getActionIndex();
        int maskedAction = event.getActionMasked();
        if(mRenderer.isCompleted()) return false;
        switch (maskedAction){
            case MotionEvent.ACTION_DOWN: {
                Vector2D d = new Vector2D(adjustCoordinate(event.getX(pointerIndex)), -1f*adjustCoordinate(event.getY(pointerIndex)));
                stitchPointer[pointerIndex] = mRenderer.getStitchNumber(d);
                break;
            }
            case MotionEvent.ACTION_POINTER_DOWN: {
                if(pointerIndex>1) break;
                Vector2D d = new Vector2D(adjustCoordinate(event.getX(pointerIndex)), -1f*adjustCoordinate(event.getY(pointerIndex)));
                stitchPointer[pointerIndex] = mRenderer.getStitchNumber(d);
                break;
            }
            case MotionEvent.ACTION_MOVE:{
                for (int size = event.getPointerCount(), i = 0; i < size && i < 2; i++) {
                    Vector2D d = new Vector2D(adjustCoordinate(event.getX(i)), -1f*adjustCoordinate(event.getY(i)));
                    mRenderer.getActiveStitch().moveStitch(d,stitchPointer[i]);
                }
                invalidate();
                break;

            }
            case MotionEvent.ACTION_POINTER_UP: {
                if (pointerIndex > 1) break;
                stitchPointer[pointerIndex] = -1;
                break;
            }
            case MotionEvent.ACTION_UP:{
                mRenderer.checkCompleted();
                stitchPointer[pointerIndex]=-1;
            }

        }
        requestRender();

        return true;
    }


}
