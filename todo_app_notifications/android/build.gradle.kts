// android/build.gradle

buildscript {
    dependencies {
        // Plugin para Firebase
        classpath 'com.google.gms:google-services:4.4.0'
    }

    repositories {
        google()
        mavenCentral()
    }
    
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

tasks.register("clean", Delete) {
    delete rootProject.buildDir
}
