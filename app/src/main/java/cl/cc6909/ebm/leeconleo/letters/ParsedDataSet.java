package cl.cc6909.ebm.leeconleo.letters;

public class ParsedDataSet {
    private String parentTag = null;
    private float x = Float.NaN;
    private float y = Float.NaN;
    private float v1x = Float.NaN;
    private float v1y = Float.NaN;
    private float v2x = Float.NaN;
    private float v2y = Float.NaN;

    // parent tag
    public String getParentTag() {
        return parentTag;
    }

    public void setParentTag(String parentTag) {
        this.parentTag = parentTag;
    }

    // x
    public float getX() {
        return x;
    }

    public void setX(String x) {
        this.x = Float.parseFloat(x);
    }

    // y
    public float getY() {
        return y;
    }

    public void setY(String y) {
        this.y = Float.parseFloat(y);
    }

    public float getV1x() {
        return v1x;
    }

    public void setV1x(String v1x) {
        this.v1x = Float.parseFloat(v1x);
    }

    public float getV1y() {
        return v1y;
    }

    public void setV1y(String v1y) {
        this.v1y = Float.parseFloat(v1y);
    }

    public float getV2x() {
        return v2x;
    }

    public void setV2x(String v2x) {
        this.v2x = Float.parseFloat(v2x);
    }

    public float getV2y() {
        return v2y;
    }

    public void setV2y(String v2y) {
        this.v2y = Float.parseFloat(v2y);
    }
}