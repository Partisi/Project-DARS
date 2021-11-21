import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class CleanIndustryMapper extends Mapper<LongWritable, Text, Text, IntWritable> {
    private static final int MISSING = 9999;

    @Override
    public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {

        String[] eachRecord = value.toString().split(",(?=([^\"]*\"[^\"]*\")*[^\"]*$)");
        if (eachRecord.length >= 100) {
            if (eachRecord[0].contains("All industries") | eachRecord[0].contains("Date") | eachRecord[0].contains("it / computing / software") | eachRecord[0].contains("marketing / advertising / pr") | eachRecord[0].contains("retail / wholesale")) {
                String output = "";
                for (int i = 0, j = 100; i < j; i++) {
                    output += eachRecord[i];
                    output += ",";
                }
                context.write(new Text(output), new IntWritable(1));
            }
           
           
        }
    }
}