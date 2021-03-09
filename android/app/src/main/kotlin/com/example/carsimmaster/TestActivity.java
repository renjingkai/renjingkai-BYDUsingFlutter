package com.example.carsimmaster;

import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.util.Log;

import androidx.annotation.Nullable;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Locale;

public class TestActivity extends Activity {

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState, @Nullable PersistableBundle persistentState) {
        Log.e("TAF", "result");
        sHA1(getApplicationContext());
        super.onCreate(savedInstanceState, persistentState);
    }

    public  String sHA1(Context context){
        try {
            PackageInfo info = context.getPackageManager().getPackageInfo(
                    context.getPackageName(), PackageManager.GET_SIGNATURES);
            byte[] cert = info.signatures[0].toByteArray();
            MessageDigest md = MessageDigest.getInstance("SHA1");
            byte[] publicKey = md.digest(cert);
            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < publicKey.length; i++) {
                String appendString = Integer.toHexString(0xFF & publicKey[i])
                        .toUpperCase(Locale.US);
                if (appendString.length() == 1)
                    hexString.append("0");
                hexString.append(appendString);
                hexString.append(":");
            }
            String result = hexString.toString();
            Log.e("TAF", result);
            return result.substring(0, result.length()-1);
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }
}
