package com.womenwhocode.tokyo.event

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
                30)

        return events.map { event ->
            val venue = RepositoryEvent.Venue(
                    event.venue.name,
                    event.venue.lat,
                    event.venue.lon,
                    event.venue.address_1,
                    event.venue.city)

            RepositoryEvent(
                    event.name,
                    event.local_date,
                    event.local_time,
                    event.duration,
                    event.description,
                    venue,
                    event.link)
        }
    }
}
