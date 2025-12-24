package com.antonseagull.capacitor.mindbox.sdk

import android.util.Log

class CapMindbox {
    fun echo(value: String): String {
        Log.i("Echo", value)
        return value
    }
}
