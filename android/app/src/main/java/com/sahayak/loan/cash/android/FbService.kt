package com.sahayak.loan.cash.android

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Intent
import android.media.RingtoneManager
import android.os.Build
import androidx.core.app.NotificationCompat
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.sahayak.loan.cash.android.MainActivity

class FbService : FirebaseMessagingService() {

    override fun onNewToken(s: String) {
        sendRegistrationToServer(s)
    }

    private fun sendRegistrationToServer(token: String) {}

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        if (remoteMessage.notification != null) {
            sendNotification(remoteMessage.notification, remoteMessage.data)
        }
    }

    private fun sendNotification(it: RemoteMessage.Notification?, data: Map<String, String>) {
        val intent = Intent(this, MainActivity::class.java)
        data.forEach { (key, value) -> intent.putExtra(key, value);}
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
        val pendingIntent = PendingIntent.getActivity(
            this, 0 , intent,
            PendingIntent.FLAG_ONE_SHOT
        )
        var channelId = it!!.channelId
        if (channelId == null || channelId.isEmpty()) {
            channelId = packageName
        }
        var title = it.title
        if (title == null || title.isEmpty()) {
            title = applicationInfo.name
        }
        val defaultSoundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
        val notificationBuilder = NotificationCompat.Builder(
            this,
            channelId!!
        ) .setContentTitle(title)
            .setContentText(it.body)
            .setAutoCancel(true)
            .setSound(defaultSoundUri)
            .setContentIntent(pendingIntent)
        val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                channelId,
                applicationInfo.name,
                NotificationManager.IMPORTANCE_DEFAULT
            )
            notificationManager.createNotificationChannel(channel)
        }
        notificationManager.notify(0 , notificationBuilder.build())
    }
}