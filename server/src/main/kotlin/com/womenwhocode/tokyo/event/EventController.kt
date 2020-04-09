package com.womenwhocode.tokyo.event

import com.womenwhocode.tokyo.meetupapi.EventType.PAST
import com.womenwhocode.tokyo.meetupapi.EventType.UPCOMING
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class EventController(val service: EventService) {

    @GetMapping("/api/events/upcoming")
    fun upcomingEvents(): List<WWCEvent> {
        return service.getEvents(UPCOMING)
    }

    @CrossOrigin(origins = ["http://localhost:3000"])
    @GetMapping("/api/events/past")
    fun pastEvents(): List<WWCEvent> {
        return service.getEvents(PAST)
    }
}
