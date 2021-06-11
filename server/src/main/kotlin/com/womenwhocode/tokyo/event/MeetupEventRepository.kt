package com.womenwhocode.tokyo.event

import com.womenwhocode.tokyo.event.RepositoryEvent.Location
import com.womenwhocode.tokyo.meetupapi.EventType
import com.womenwhocode.tokyo.meetupapi.MeetupAPIClient
import org.springframework.stereotype.Repository

@Repository
class MeetupEventRepository(val meetupAPIClient: MeetupAPIClient) {
    fun getEvents(status: EventType): List<RepositoryEvent> {
        val events = meetupAPIClient.getEvents(
            true,
            "public",
            status.meetupAPIEventTypeCode,
            status == EventType.PAST,
            "2019-06-01T00:00:00.000",
            30
        )
        return events.map { event ->
            val venue = if (event.venue?.name != null) RepositoryEvent.Venue(
                event.venue.name,
                if (event.venue.address_1 != null) Location(
                    event.venue.lat!!,
                    event.venue.lon!!,
                    event.venue.address_1,
                    event.venue.city!!
                ) else null
            ) else null

            RepositoryEvent(
                event.id,
                event.name,
                event.local_date,
                event.local_time,
                event.duration,
                event.description,
                venue,
                event.link
            )
        }
    }
}
