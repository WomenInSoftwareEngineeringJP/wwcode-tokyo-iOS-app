package com.womenwhocode.tokyo.web

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class EventController(val meetupEventRepository: MeetupEventRepository) {

    @GetMapping("/api/events")
    fun events(): List<Event> {
        return meetupEventRepository.getEvents()
    }
}
