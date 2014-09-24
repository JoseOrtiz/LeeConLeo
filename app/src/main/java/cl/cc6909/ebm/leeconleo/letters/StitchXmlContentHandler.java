package cl.cc6909.ebm.leeconleo.letters;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import java.util.ArrayList;
import java.util.List;

public class StitchXmlContentHandler extends DefaultHandler{
    private static final String LOG_TAG = "XmlContentHandler";

    // used to track of what tags are we
    private boolean inContour = false;
    private boolean inVector = false;
    private boolean inV1 = false;

    // accumulate the values
    private StringBuilder mStringBuilder = new StringBuilder();

    // new object
    private ParsedDataSet mParsedDataSet = new ParsedDataSet();

    // the list of data
    private List<ParsedDataSet> mParsedDataSetList = new ArrayList<ParsedDataSet>();

    /*
     * Called when parsed data is requested.
     */
    public List<ParsedDataSet> getParsedData() {
        return this.mParsedDataSetList;
    }

    // Methods below are built in, we just have to do the tweaks.

    /*
     * @Receive notification of the start of an element.
     *
     * @Called in opening tags such as <Owner>
     */
    @Override
    public void startElement(String namespaceURI, String localName,
                             String qName, Attributes atts) throws SAXException {

        if (localName.equalsIgnoreCase("contour")) {
            // meaning new data object will be made
            this.mParsedDataSet = new ParsedDataSet();
            this.inContour = true;
        }

        else if (localName.equalsIgnoreCase("vector")) {
            this.mParsedDataSet = new ParsedDataSet();
            this.inVector = true;
            this.inV1 = true;
        }

    }

    /*
     * @Receive notification of the end of an element.
     *
     * @Called in end tags such as </Owner>
     */
    @Override
    public void endElement(String namespaceURI, String localName, String qName)
            throws SAXException {

        // Contours
        if (this.inContour == true && localName.equalsIgnoreCase("contour")) {
            this.mParsedDataSetList.add(mParsedDataSet);
            mParsedDataSet.setParentTag("contour");
            this.inContour= false;
        }

        else if (this.inContour == true && localName.equals("x")) {
            mParsedDataSet.setX(mStringBuilder.toString().trim());
        }

        else if (this.inContour == true && localName.equals("y")) {
            mParsedDataSet.setY(mStringBuilder.toString().trim());
        }


        // vector
        if (this.inVector == true && localName.equalsIgnoreCase("vector")) {
            this.mParsedDataSetList.add(mParsedDataSet);
            mParsedDataSet.setParentTag("vector");
            this.inVector = false;
        }

        else if(this.inVector && localName.equalsIgnoreCase("v1")){
            this.inV1 = false;
        }
        else if(this.inVector && localName.equalsIgnoreCase("v2")){
            this.inV1 = true;
        }

        else if (this.inVector == true && localName.equals("x")) {
            if(this.inV1) {
                mParsedDataSet.setV1x(mStringBuilder.toString().trim());
            }else {
                mParsedDataSet.setV2x(mStringBuilder.toString().trim());
            }
        }

        else if (this.inVector == true && localName.equals("y")) {
            if(this.inV1) {
                mParsedDataSet.setV1y(mStringBuilder.toString().trim());
            }else {
                mParsedDataSet.setV2y(mStringBuilder.toString().trim());
            }
        }

        // empty our string builder
        mStringBuilder.setLength(0);
    }

    /*
     * @Receive notification of character data inside an element.
     *
     * @Gets be called on the following structure: <tag>characters</tag>
     */
    @Override
    public void characters(char ch[], int start, int length) {
        // append the value to our string builder
        mStringBuilder.append(ch, start, length);
    }
}
