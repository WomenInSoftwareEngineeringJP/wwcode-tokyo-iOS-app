package com.womenwhocode.tokyo.web

import org.springframework.cloud.openfeign.FeignClient
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam

@FeignClient(name = "meetup", url = "https://api.meetup.com/Women-Who-Code-Tokyo")
interface MeetupClient {
    @GetMapping("/events")
    fun getEvents(@RequestParam(name = "sign") sign: Boolean,
                  @RequestParam(name = "photo-host") photoHost: String,
                  @RequestParam(name = "status") status: String,
                  @RequestParam(name = "no_earlier_than") noEarlierThan: String,
                  @RequestParam(name = "page") page: Int): List<MeetupEvent>
}
