import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
}

val keystorePropertiesFile = rootProject.file("key.properties")
check(keystorePropertiesFile.exists()) {
    "Missing ${keystorePropertiesFile.path}. Copy the shared keystore setup " +
        "(gitignored key.properties + ermeo-shared.jks) before building."
}

val keystoreProperties = Properties().apply {
    keystorePropertiesFile.inputStream().use { load(it) }
}

val sharedStoreFile = file(keystoreProperties.getProperty("storeFile"))
check(sharedStoreFile.exists()) {
    "Missing keystore at ${sharedStoreFile.path}. Update storeFile in key.properties."
}

android {
    namespace = "com.lerpof.ermeo"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    buildFeatures {
        resValues = true
    }

    defaultConfig {
        applicationId = "com.lerpof.ermeo"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    flavorDimensions += "environment"
    productFlavors {
        create("dev") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
            resValue("string", "app_name", "Ermeo Dev")
        }
        create("prod") {
            dimension = "environment"
            resValue("string", "app_name", "Ermeo")
        }
    }

    signingConfigs {
        create("shared") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
            storeFile = sharedStoreFile
            storePassword = keystoreProperties.getProperty("storePassword")
        }
    }

    buildTypes {
        getByName("debug") {
            signingConfig = signingConfigs.getByName("shared")
        }
        release {
            signingConfig = signingConfigs.getByName("shared")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
