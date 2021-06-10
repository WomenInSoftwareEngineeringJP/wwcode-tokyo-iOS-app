package com.womenwhocode.tokyo.meetupapi

import org.springframework.cloud.openfeign.FeignClient
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam

@FeignClient(name = "meetup", url = "https://api.meetup.com/Women-Who-Code-Tokyo")
interface MeetupAPIClient {
    @GetMapping("/events")
    fun getEvents(
        @RequestParam(name = "sign") sign: Boolean,
        @RequestParam(name = "photo-host") photoHost: String,
        @RequestParam(name = "status") status: String,
        @RequestParam(name = "desc") descending: Boolean,
        @RequestParam(name = "no_earlier_than") noEarlierThan: String,
        @RequestParam(name = "page") page: Int
    ): List<MeetupAPIEvent>
}
