accessing - monitor
monitorStopTimeout
	"Answer the amount of time that can wait for each monitor to stop."

	^ monitorStopTimeout ifNil: [ monitorStopTimeout := 40 seconds ]