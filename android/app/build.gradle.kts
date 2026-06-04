import java.util.Properties
import java.io.FileInputStream

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.eliobn.weather_forecast"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.eliobn.weather_forecast"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    val keyAlias = keystoreProperties["keyAlias"] as? String
    val keyPassword = keystoreProperties["keyPassword"] as? String
    val storeFile = (keystoreProperties["storeFile"] as? String)?.let { file(it) }
    val storePassword = keystoreProperties["storePassword"] as? String

    requireNotNull(keyAlias) { "keyAlias is missing from keystore.properties" }
    requireNotNull(keyPassword) { "keyPassword is missing from keystore.properties" }
    requireNotNull(storeFile) { "storeFile is missing or invalid in keystore.properties" }
    requireNotNull(storePassword) { "storePassword is missing from keystore.properties" }

    signingConfigs {
        create("release") {
            this.keyAlias = keyAlias
            this.keyPassword = keyPassword
            this.storeFile = storeFile
            this.storePassword = storePassword
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
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
