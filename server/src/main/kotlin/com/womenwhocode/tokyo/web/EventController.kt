package com.womenwhocode.tokyo.web

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

@RestController
class EventController(val service: EventService) {

    @GetMapping("/api/events")
    fun events(@RequestParam(name = "status", defaultValue = "upcoming") status: String): List<WWCEvent> {
        return service.getEvents(status)
    }
}
