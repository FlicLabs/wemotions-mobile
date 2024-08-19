package com.subverse.vible

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.graphics.Bitmap
import android.net.Uri
import android.widget.ImageView
import android.widget.RemoteViews

import es.antonborri.home_widget.HomeWidgetPlugin
import com.bumptech.glide.Glide
import com.bumptech.glide.load.engine.DiskCacheStrategy
import com.bumptech.glide.request.target.AppWidgetTarget

/**
 * Implementation of App Widget functionality.
 */

object Constants {
    const val imageUrl = "https://socialverse-cdn-assets.s3.amazonaws.com/images/IMG_2545.JPG"
}


class VibleWidgets : AppWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            // Get reference to SharedPreferences
            val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.vible_widgets).apply {

                val title = widgetData.getString("title", null)
                setTextViewText(R.id.title, title ?: "The best vibes!")

                val description = widgetData.getString("description", null)
                setTextViewText(R.id.description, description ?: "The best vibes!")

                val imageUrl = widgetData.getString("image", null)

                if (imageUrl != null) {
                    // Load the network image using Glide and set it in the ImageView
                    setImageWithGlide(context, imageUrl, this, appWidgetId)
                } else {
                    setImageWithGlide(context, Constants.imageUrl, this, appWidgetId)
                }
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    private fun setImageWithGlide(context: Context, imageUrl: String, views: RemoteViews, appWidgetId: Int) {
        Glide.with(context)
                .asBitmap()
                .load(imageUrl)
                .diskCacheStrategy(DiskCacheStrategy.ALL) // Cache the image
                .into(AppWidgetTarget(context, R.id.image_view, views, appWidgetId))
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

internal fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
    val widgetText = context.getString(R.string.appwidget_text)
    // Construct the RemoteViews object
    val views = RemoteViews(context.packageName, R.layout.vible_widgets)
    views.setTextViewText(R.id.widget_container, widgetText)

    // Instruct the widget manager to update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}