// under default settings, LOGLEVEL.TRACE is disabled, so this is not output
logger(LOGLEVEL.TRACE, "This is a trace");

// we can set the level though
logger_set_level(LOGLEVEL.TRACE);

// now it'll output
logger(LOGLEVEL.TRACE, "Let's try that again");

// Loggers can have a custom "logger name" it can be used as a "who is outputting this log"?
logger(LOGLEVEL.DEBUG, "Hello World", "User");

// "logger name" can be hierarchical, and dot-separated. A good way to filter logs and 
// see only logs relating to a particular functionality in your code
logger(LOGLEVEL.INFO, "Hello World2", "User.Output");

// Loggers can have additional parameters attached to it to help debugging
// the below sets cats=7, dogs=2 as additional params in the log
logger(LOGLEVEL.INFO, "New pets", "Cats", "pet_names", ["Spot", "Felix", "Clifford"])

// Sometimes it's useful to store these attached params so they appear
// inside every log message. This helps with finding data in the logs
// a scoped logger is created. this scoped logger contains the logger name
// and additional params and can be used instead of the logger_name argument
var log = logger_scoped("Cats.Scoped", "cats", 12, "dogs", 9);
logger(LOGLEVEL.WARN, "Too many cats", log);
logger(LOGLEVEL.WARN, "Not enough dogs", log);

// more parameters can be bound to the scoped logger. Existing parameters
// cannot be changed, and adding the same value will cause duplicate parameters
// there is no mechanism to prevent this
logger_bind(log, "cows", 7);
logger(LOGLEVEL.WARN, "Got milk?", log);

// scoped loggers can still have more parameters attached for just one log message
// this does not bind them to the scoped logger
logger(LOGLEVEL.FATAL, "The End", log, "end", true);

// logger actually has one final argument, which if set to true will append all the
// parameters onto the log message for easy log filtering
logger(LOGLEVEL.ERROR, "Here are my values =>", log, true);

// scoped loggers can be copied and used with a new name. the parameters attached are
// copied with it
var new_log = logger_scoped_copy(log, "Dogs.Scoped")

// logger_text is a helper function to avoid having to append +string(var)+ all the time
logger(LOGLEVEL.INFO, logger_text("a:", 1, " (", typeof(1), ")"), new_log)
