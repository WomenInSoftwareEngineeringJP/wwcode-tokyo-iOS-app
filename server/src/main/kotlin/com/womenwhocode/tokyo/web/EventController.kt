package com.womenwhocode.tokyo.web

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class EventController(val service: EventService) {

    @GetMapping("/api/events")
    fun events(): List<WWCEvent> {
        return service.getEvents()
    }
}
