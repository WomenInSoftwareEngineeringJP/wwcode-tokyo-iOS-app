package com.womenwhocode.tokyo.web

import org.springframework.stereotype.Repository

@Repository
class MeetupEventRepository(val meetupClient: MeetupClient) {
    fun getEvents(): List<Event> {
        val meetupEvents = meetupClient.getEvents(true, "public", "recent_past", 20)
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
