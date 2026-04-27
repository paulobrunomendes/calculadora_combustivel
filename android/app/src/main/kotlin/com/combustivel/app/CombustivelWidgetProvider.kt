package com.combustivel.app

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

class CombustivelWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            val data = HomeWidgetPlugin.getData(context)
            val custo = data.getString("custo", "--") ?: "--"
            val distancia = data.getString("distancia", "") ?: ""
            val combustivel = data.getString("combustivel", "") ?: ""

            val views = RemoteViews(context.packageName, R.layout.combustivel_widget)
            views.setTextViewText(R.id.widget_custo, custo)
            val info = if (distancia.isNotEmpty()) "$distancia • $combustivel"
                       else "Abra o app e calcule"
            views.setTextViewText(R.id.widget_info, info)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
