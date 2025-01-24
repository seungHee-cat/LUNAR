package project.kr.com.util;

import java.time.Duration;
import java.time.LocalDateTime;

public class TimeAgoUtil {

    public static String timeAgo(LocalDateTime dateTime) {
        Duration duration = Duration.between(dateTime, LocalDateTime.now());

        if (duration.getSeconds() < 60) return duration.getSeconds() + "초 전";
        if (duration.toMinutes() < 60) return duration.toMinutes() + "분 전";
        if (duration.toHours() < 24) return duration.toHours() + "시간 전";
        if (duration.toDays() < 30) return duration.toDays() + "일 전";
        if (duration.toDays() < 365) return (duration.toDays() / 30) + "개월 전";
        return (duration.toDays() / 365) + "년 전";
    }

}
