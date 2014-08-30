package cl.cc6909.ebm.leeconleo.obstacles;


public class Vector2D {
    private double x;
    private double y;
    public Vector2D(double x, double y){
        this.x = x;
        this.y = y;
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double scalar(){
        return Math.pow((x*x+y*y),0.5);
    }

    public static Vector2D add(Vector2D v1, Vector2D v2){
        return new Vector2D(v1.getX()+v2.getX(),v1.getY()+v2.getY());
    }

    public static Vector2D subtract(Vector2D v1, Vector2D v2){
        return new Vector2D(v1.getX()-v2.getX(),v1.getY()-v2.getY());
    }

    public static Vector2D multiply(double a, Vector2D v){
        return new Vector2D(a*v.getX(),a*v.getY());
    }

    public static Vector2D norm(Vector2D v){
        double n = v.scalar();
        if (n>0){
            return new Vector2D(v.getX()/n,v.getY()/n);
        }
        else
            return v;
    }

    public double distance(Vector2D v1, Vector2D v2){
        return subtract(v1,v2).scalar();
    }
}
