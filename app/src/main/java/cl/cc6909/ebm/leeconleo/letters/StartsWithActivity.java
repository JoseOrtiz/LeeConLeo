package cl.cc6909.ebm.leeconleo.letters;

import android.os.Bundle;
import android.view.View;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Stack;

public class StartsWithActivity extends RecognitionActivity {
    private Stack<Image[]> pictures;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        letter = getIntent().getStringExtra("letter");
        InputStream is = null;
        InputStreamReader isr = null;
        BufferedReader br = null;
        pictures = new Stack<Image[]>();

        try {
            is = getResources().getAssets().open("startsWith/" + letter.toUpperCase() + ".txt");
            isr = new InputStreamReader(is);
            br = new BufferedReader(isr);
            String line;
            while((line=br.readLine())!=null){
                String[] split = line.split(",");
                Image[] aux = new Image[split.length];
                int i=0;
                for(String s:split){
                    aux[i++] = new Image(s,"pictures/",this);
                }
                pictures.push(aux);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            try {
                if (is != null) {
                    is.close();
                }
                if (isr != null) {
                    isr.close();
                }
                if (br != null) {
                    br.close();
                }
            } catch (Exception e) {
            }
        }
        if(!pictures.empty())
            picture = pictures.pop();
        super.onCreate(savedInstanceState);
    }

    @Override
    public void checkAnswer(View view){
        String answer = (String) view.getTag();
        if(answer.startsWith(letter)){
            pd.setGoodFeedback();
            pd.show();
            h.postDelayed(r, 2000);
            if(!pictures.empty())
                picture = pictures.pop();
        }
    }
}
