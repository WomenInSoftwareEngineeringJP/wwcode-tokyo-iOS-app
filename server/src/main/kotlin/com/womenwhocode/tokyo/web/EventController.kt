package com.womenwhocode.tokyo.web

import com.womenwhocode.tokyo.web.EventType.*
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class EventController(val service: EventService) {

    @GetMapping("/api/events/upcoming")
    fun upcomingEvents(): List<WWCEvent> {
        return service.getEvents(UPCOMING)
    }

    @GetMapping("/api/events/past")
    fun pastEvents(): List<WWCEvent> {
        return service.getEvents(PAST)
    }
}
