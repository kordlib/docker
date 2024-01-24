# docker

Docker base images for running Kord Native applications

This image can be used as a base for the upcoming Kord Native target, please read kordlib/kord#69 for more information

# Configure for proper compilation

Since the images are alpine based you need to configure your compilation accordingly.
Please also read [KT-38876](https://youtrack.jetbrains.com/issue/KT-38876/#focus=Comments-27-4805258.0-0) for more information

```kotlin
kotlin {
  linuxX64 {
    binaries.executable {
        linkerOpts("--as-needed", "--defsym=isnan=isnan")
        freeCompilerArgs = freeCompilerArgs + listOf("-Xoverride-konan-properties=linkerGccFlags=-lgcc -lgcc_eh -lc")
    }
 }
}
```

# Example Usage
```Dockerfile
FROM ghcr.io/kordlib/docker:main

WORKDIR /usr/app
COPY yourbinary /usr/app/yourbinary

ENTRYPOINT ["/usr/app/yourbinary"]
```
