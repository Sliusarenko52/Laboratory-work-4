CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    age INTEGER CHECK (
        age >= 6 AND age <= 99
    ),
    weight FLOAT CHECK (
        weight >= 20.0 AND weight <= 200.0
    )
);

CREATE TABLE exercise_routines (
    routine_id INTEGER PRIMARY KEY,
    routine_title VARCHAR(100) NOT NULL,
    difficulty_level VARCHAR(20),
    target_muscle_group VARCHAR(100)
);

CREATE TABLE workout_sessions (
    session_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    routine_id INTEGER,
    start_date TIMESTAMP,
    duration_sec INTEGER CHECK (duration_sec > 0),
    overall_accuracy FLOAT CHECK (
        overall_accuracy >= 0.0 AND overall_accuracy <= 100.0
    ),
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (routine_id) REFERENCES exercise_routines (routine_id)
);

CREATE TABLE joint_analyses (
    analysis_id INTEGER PRIMARY KEY,
    session_id INTEGER,
    joint_title VARCHAR(50) NOT NULL,
    current_flexion_angle FLOAT CHECK (
        current_flexion_angle >= 0.0 AND current_flexion_angle <= 360.0
    ),
    reference_amplitude VARCHAR(50) CHECK (
        reference_amplitude REGEXP '^[0-9]{1,3}-[0-9]{1,3}$'
    ),
    FOREIGN KEY (session_id) REFERENCES workout_sessions (session_id)
);

CREATE TABLE feedbacks (
    feedback_id INTEGER PRIMARY KEY,
    analysis_id INTEGER,
    notification_type VARCHAR(10) CHECK (
        notification_type REGEXP '^(visual|audio)$'
    ),
    error_text VARCHAR(200),
    detection_time_ms INTEGER CHECK (detection_time_ms >= 0),
    FOREIGN KEY (analysis_id) REFERENCES joint_analyses (analysis_id)
);
