package com.womenwhocode.tokyo.web

import com.nhaarman.mockitokotlin2.doReturn
import com.nhaarman.mockitokotlin2.mock
import org.hamcrest.CoreMatchers.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test


class EventServiceTest {

    private lateinit var meetupEventRepository: MeetupEventRepository
    private lateinit var subject: EventService

    @BeforeEach
    internal fun setUp() {
        val eventList = listOf<Event>(
                Event("PAL training!",
                        "2020-12-24",
                        "19:30",
                        7200000,
                        "Pivotal Japan")
        )
        meetupEventRepository = mock {
            on { getEvents() } doReturn eventList
        }

        subject = EventService(meetupEventRepository)
    }

    @Test
    fun `get events return WWCEvents`() {
        val events = subject.getEvents()

        assertThat(events[0].date, equalTo("Dec 24, Thu"))
        assertThat(events[0].time, equalTo("19:30 - 21:30"))
        assertThat(events[0].name, equalTo("PAL training!"))
        assertThat(events[0].venueName, equalTo("Pivotal Japan"))
    }
}