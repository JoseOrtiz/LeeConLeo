package cl.cc6909.ebm.leeconleo.letters;

import android.app.Activity;
import android.content.Context;
import android.opengl.GLES20;
import android.opengl.GLSurfaceView;
import android.util.Log;

import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;

import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import cl.cc6909.ebm.leeconleo.Vector2D;

public class StitchRenderer implements GLSurfaceView.Renderer {
    public static final String LOG_TAG = "StitchRenderer";

    private final String letter;
    private final Context mContext;
    private Vector<Stitch> stitch;
    private Contour contour;
    private int current;

    public StitchRenderer(Context context){
        mContext = context;
        letter = ((Activity) mContext).getIntent().getStringExtra("letter");
    }
    @Override
    public void onSurfaceCreated(GL10 gl, EGLConfig config) {
        stitch = new Vector<Stitch>();
        setVertex();
        current=-1;
        if(!stitch.isEmpty()){
            current=0;
        }
        contour.addCenter(stitch.elementAt(current).getCenter());
    }

    private void setVertex() {
        try {
            InputSource inputSource = new InputSource(mContext.getAssets().open("stitch/" + letter.toUpperCase() + ".xml"));
            // instantiate SAX parser
            SAXParserFactory saxParserFactory = SAXParserFactory.newInstance();
            SAXParser saxParser = saxParserFactory.newSAXParser();

            // get the XML reader
            XMLReader xmlReader = saxParser.getXMLReader();

            // prepare and set the XML content or data handler before
            // parsing
            StitchXmlContentHandler xmlContentHandler = new StitchXmlContentHandler();
            xmlReader.setContentHandler(xmlContentHandler);

            // parse the XML input source
            xmlReader.parse(inputSource);

            // put the parsed data to a List
            List<ParsedDataSet> parsedDataSet = xmlContentHandler.getParsedData();

            // we'll use an iterator so we can loop through the data
            Iterator<ParsedDataSet> i = parsedDataSet.iterator();
            ParsedDataSet dataItem;
            while (i.hasNext()) {

                dataItem = i.next();

                    /*
                     * parentTag can also represent the main type of data, in
                     * our example, "Owners" and "Dogs"
                     */
                String parentTag = dataItem.getParentTag();
                Log.v(LOG_TAG, "parentTag: " + parentTag);

                if (parentTag.equals("contour")) {
                    contour = new Contour(new Vector2D(dataItem.getX(),dataItem.getY()));
                }

                else if (parentTag.equals("vector")) {
                    stitch.add(new Stitch(new Vector2D(dataItem.getV1x(),dataItem.getV1y()),new Vector2D(dataItem.getV2x(), dataItem.getV2y())));
                }

            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    @Override
    public void onSurfaceChanged(GL10 gl, int width, int height) {

    }

    @Override
    public void onDrawFrame(GL10 gl) {
        for(Stitch s:stitch) {
            s.draw();
        }
        contour.draw();
    }

    public Stitch getActiveStitch(){
        return stitch.elementAt(current);
    }

    public int getStitchNumber(Vector2D position){
        Stitch activeStitch = getActiveStitch();
        if(Vector2D.distance(activeStitch.getStitch(0),position)<0.1f){
            return 0;
        }
        if(Vector2D.distance(activeStitch.getStitch(1),position)<0.1f){
            return 1;
        }
        return -1;
    }


    public void checkCompleted(){
        if(getActiveStitch().checkCompleted()){
            current++;
            try {
                contour.addCenter(stitch.elementAt(current).getCenter());
            }catch (Exception e){}
        }
    }

    public boolean isCompleted(){
        return current>=stitch.size();
    }


    /**
     * Utility method for compiling a OpenGL shader.
     *
     * <p><strong>Note:</strong> When developing shaders, use the checkGlError()
     * method to debug shader coding errors.</p>
     *
     * @param type - Vertex or fragment shader type.
     * @param shaderCode - String containing the shader code.
     * @return - Returns an id for the shader.
     */
    public static int loadShader(int type, String shaderCode){

        // create a vertex shader type (GLES20.GL_VERTEX_SHADER)
        // or a fragment shader type (GLES20.GL_FRAGMENT_SHADER)
        int shader = GLES20.glCreateShader(type);

        // add the source code to the shader and compile it
        GLES20.glShaderSource(shader, shaderCode);
        GLES20.glCompileShader(shader);

        return shader;
    }
}
