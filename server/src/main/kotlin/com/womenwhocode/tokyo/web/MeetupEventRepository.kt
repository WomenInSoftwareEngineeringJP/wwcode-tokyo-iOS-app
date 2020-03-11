package com.womenwhocode.tokyo.web

import org.springframework.stereotype.Repository

@Repository
class MeetupEventRepository(val meetupClient: MeetupClient) {
    fun getEvents(status: String = "upcoming"): List<Event> {
        val meetupEvents = meetupClient.getEvents(true, "public", status, "2019-06-01T00:00:00.000",30)
        return meetupEvents.map { meetupEvent -> Event(
                meetupEvent.name,
                meetupEvent.local_date,
                meetupEvent.local_time,
                meetupEvent.duration,
                meetupEvent.venue.name
            )
        }
    }
}
