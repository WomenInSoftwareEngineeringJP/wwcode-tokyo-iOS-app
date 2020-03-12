package com.womenwhocode.tokyo.web

import org.springframework.stereotype.Service
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

@Service
class EventService(val repo: MeetupEventRepository) {
    fun getEvents(status: EventType): List<WWCEvent> {
        return repo.getEvents(status)
                .map {
                    WWCEvent(
                            it.name,
                            formatDate(it.date),
                            formatTime(it.duration, it.date, it.time),
                            it.venueName)
                }
    }

    private fun formatDate(date: String): String {
        val localDate = LocalDate.parse(date)
        val formatter = DateTimeFormatter.ofPattern("MMM dd, EEE")
        return localDate.format(formatter)
    }

    private fun formatTime(duration: Int, date: String, time: String): String {
        val durationInMinutes = duration / 1000 / 60

        val dateTime = LocalDateTime.parse("${date}T${time}:00")
        val endDateTime = dateTime.plusMinutes(durationInMinutes.toLong())

        val endTimeFormatter = DateTimeFormatter.ofPattern("kk:mm")
        val endTime = endDateTime.format(endTimeFormatter)
        return "$time - $endTime"
    }
}
