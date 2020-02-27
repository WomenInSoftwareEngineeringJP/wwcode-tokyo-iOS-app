package com.womenwhocode.tokyo.web

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.cloud.openfeign.EnableFeignClients

@SpringBootApplication
@EnableFeignClients
class WebApplication

fun main(args: Array<String>) {
    runApplication<WebApplication>(*args)
}