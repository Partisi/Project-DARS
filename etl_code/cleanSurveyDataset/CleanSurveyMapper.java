import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class CleanSurveyMapper extends Mapper<LongWritable, Text, Text, IntWritable> {
    private static final int MISSING = 9999;

    @Override
    public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {

        String[] eachRecord = value.toString().split(",(?=([^\"]*\"[^\"]*\")*[^\"]*$)");

        //  "Well Being, Productivity, Boredom, Office Setup, Office Communication, Loneliness, Age, Gender"
        if (!value.toString().contains("StartDate")) {
            if (eachRecord.length >= 260) {
                Text outputKey = new Text(eachRecord[20] + "," + eachRecord[25] + "," + eachRecord[48] + ","
                        + eachRecord[114] + "," + eachRecord[117] + "," + eachRecord[161] + "," + eachRecord[260] + ","
                        + eachRecord[261]);
                context.write(new Text(outputKey), new IntWritable(1));
            }

        }

    }
}