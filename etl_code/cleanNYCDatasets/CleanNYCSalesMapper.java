import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class CleanNYCSalesMapper extends Mapper<LongWritable, Text, Text, IntWritable> {
    private static final int MISSING = 9999;

    @Override
    public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {

        String[] eachRecord = value.toString().replace(", ", " APT ").split(",(?=([^\"]*\"[^\"]*\")*[^\"]*$)");

        Map<Integer, String> boroughMap = new HashMap<>();
        boroughMap.put(1, "Manhattan");
        boroughMap.put(2, "Bronx");
        boroughMap.put(3, "Brookyln");
        boroughMap.put(4, "Queens");
        boroughMap.put(5, "Staten Island");

        if (eachRecord.length == 21) {
            if (eachRecord[0].chars().allMatch(Character::isDigit) & (eachRecord[7].length() == 2)) {
                if (eachRecord[7].charAt(0) == 'O') {
                    Text outputKey = new Text(boroughMap.get(Integer.parseInt(eachRecord[0])) + "," + eachRecord[1] + "," + eachRecord[8] + ","
                            + eachRecord[10] + "," + eachRecord[12] + "," + eachRecord[13] + "," + eachRecord[16] + ","
                            + Integer.parseInt(eachRecord[19].replace(",", "").replace("\"", "")) + "," + eachRecord[20]);
                    context.write(new Text(outputKey), new IntWritable(1));
                }
            } else if (value.toString().contains("BOROUGH") & (eachRecord[7].length() > 0)) {
                Text outputKeyHeader = new Text(eachRecord[0] + "," + eachRecord[1] + "," + eachRecord[8] + ","
                        + eachRecord[10] + "," + eachRecord[12] + "," + eachRecord[13] + "," + eachRecord[16] + ","
                        + "SALE PRICE" + "," + eachRecord[19]);
                context.write(new Text(outputKeyHeader), new IntWritable(1));
            }
        }
    }
}