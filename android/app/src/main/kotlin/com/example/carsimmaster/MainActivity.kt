package com.example.carsimmaster

import android.content.Context
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException
import java.util.*

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        Log.e("TAF" ,"-----------")
        System.out.print("________")
//        sHA1(context)
        super.onCreate(savedInstanceState, persistentState)

    }


        fun sHA1(context: Context): String? {
            try {
                val info = context.packageManager.getPackageInfo(
                        context.packageName, PackageManager.GET_SIGNATURES)
                val cert = info.signatures[0].toByteArray()
                val md = MessageDigest.getInstance("SHA1")
                val publicKey = md.digest(cert)
                val hexString = StringBuffer()
                for (i in publicKey.indices) {
                    val appendString = Integer.toHexString(0xFF and publicKey[i].toInt())
                            .toUpperCase(Locale.US)
                    if (appendString.length == 1) hexString.append("0")
                    hexString.append(appendString)
                    hexString.append(":")
                }
                val result = hexString.toString()

                Log.e("TAF" ,result)
                System.out.print(result)
                return result.substring(0, result.length - 1)
            } catch (e: PackageManager.NameNotFoundException) {
                e.printStackTrace()
            } catch (e: NoSuchAlgorithmException) {
                e.printStackTrace()
            }
            return null
        }


}
