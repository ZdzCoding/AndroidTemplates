<?xml version="1.0" encoding="utf-8"?>
<android.support.v7.widget.CardView xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:id="@+id/card"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    app:cardBackgroundColor="@android:color/white"
    app:cardElevation="4dp"
    app:contentPadding="5dp"
    app:cardMaxElevation="8dp"
    app:cardPreventCornerOverlap="true"
    app:cardUseCompatPadding="true">

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        android:padding="10dp">

        <TextView
            android:id="@+id/tv_joke_title"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_gravity="left"
            android:text="create by self"
            android:textColor="@color/black"
            android:textSize="14sp" />

        <com.facebook.drawee.view.SimpleDraweeView
            android:id="@+id/list_item_images_list_image"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginTop="16dp"
            app:viewAspectRatio="1.7"
            app:placeholderImage="@drawable/ic_default_feed"
            app:placeholderImageScaleType="centerCrop"
            app:actualImageScaleType="fitCenter">

        </com.facebook.drawee.view.SimpleDraweeView>

        <View
            android:layout_width="match_parent"
            android:layout_height="0.5dp"
            android:layout_marginBottom="16dp"
            android:layout_marginTop="16dp"
            android:background="@android:color/darker_gray" />

        <TextView
            android:id="@+id/tv_time"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="2015-11-10"
            android:textSize="12sp"/>

    </LinearLayout>
</android.support.v7.widget.CardView>
