package com.womenwhocode.tokyo.event

import com.womenwhocode.tokyo.meetupapi.EventType
import org.springframework.stereotype.Service
import java.time.LocalDateTime

@Service
class EventService(val repo: MeetupEventRepository) {
    fun getEvents(status: EventType): List<WWCEvent> {
        return repo.getEvents(status)
                .map {
                    WWCEvent(
                            it.name,
                            parseStartDateTime(it.date, it.time),
                            parseEndDateTime(it.duration, it.date, it.time),
                            it.description,
                            it.venueName)
                }
    }

    private fun parseStartDateTime(date: String, time: String): LocalDateTime {
        return LocalDateTime.parse("${date}T${time}:00")
    }

    private fun parseEndDateTime(duration: Int, date: String, time: String): LocalDateTime {
        val durationInMinutes = duration / 1000 / 60
        val dateTime = LocalDateTime.parse("${date}T${time}:00")
        return dateTime.plusMinutes(durationInMinutes.toLong())
    }
}
