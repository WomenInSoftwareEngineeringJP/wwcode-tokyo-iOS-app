package com.womenwhocode.tokyo.event

import com.nhaarman.mockitokotlin2.mock
import com.nhaarman.mockitokotlin2.whenever
import com.womenwhocode.tokyo.meetupapi.EventType.PAST
import com.womenwhocode.tokyo.meetupapi.EventType.UPCOMING
import org.hamcrest.CoreMatchers.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import java.time.LocalDateTime


class EventServiceTest {

    private lateinit var meetupEventRepository: MeetupEventRepository
    private lateinit var subject: EventService

    @BeforeEach
    internal fun setUp() {
        meetupEventRepository = mock { }
        subject = EventService(meetupEventRepository)
    }

    @Test
    fun `get events return upcoming WWCEvents`() {
        val venue = RepositoryEvent.Venue(
                "venue name",
                1.23,
                4.56,
                "venue address",
                "venue city")

        val event = RepositoryEvent("PAL training!",
                "2020-12-24",
                "19:30",
                7200000,
                "description",
                venue,
                "upcoming-example.com")

        val eventList = listOf<RepositoryEvent>(event)

        whenever(meetupEventRepository.getEvents(UPCOMING)).thenReturn(eventList)
        val events = subject.getEvents(UPCOMING)

        assertThat(events[0].startDateTime, equalTo(LocalDateTime.of(2020, 12, 24, 19, 30)))
        assertThat(events[0].endDateTime, equalTo(LocalDateTime.of(2020, 12, 24, 21, 30)))
        assertThat(events[0].name, equalTo("PAL training!"))
        assertThat(events[0].description, equalTo("description"))
        assertThat(events[0].link, equalTo("upcoming-example.com"))
        assertThat(events[0].venue.name, equalTo("venue name"))
        assertThat(events[0].venue.lat, equalTo(1.23))
        assertThat(events[0].venue.lon, equalTo(4.56))
        assertThat(events[0].venue.address, equalTo("venue address"))
        assertThat(events[0].venue.city, equalTo("venue city"))
    }

    @Test
    fun `get events return past WWCEvents`() {
        val venue = RepositoryEvent.Venue(
                "venue name",
                1.23,
                4.56,
                "venue address",
                "venue city")

        val event = RepositoryEvent(
                "past event name",
                "2019-10-31",
                "18:00",
                10800000,
                "description",
                venue,
                "past-example.com")

        val pastEvents = listOf(event)

        whenever(meetupEventRepository.getEvents(PAST)).thenReturn(pastEvents)

        val events = subject.getEvents(PAST)

        assertThat(events[0].startDateTime, equalTo(LocalDateTime.of(2019, 10, 31, 18, 0)))
        assertThat(events[0].endDateTime, equalTo(LocalDateTime.of(2019, 10, 31, 21, 0)))
        assertThat(events[0].name, equalTo("past event name"))
        assertThat(events[0].description, equalTo("description"))
        assertThat(events[0].link, equalTo("past-example.com"))
        assertThat(events[0].venue.name, equalTo("venue name"))
        assertThat(events[0].venue.lat, equalTo(1.23))
        assertThat(events[0].venue.lon, equalTo(4.56))
        assertThat(events[0].venue.address, equalTo("venue address"))
        assertThat(events[0].venue.city, equalTo("venue city"))
    }
}