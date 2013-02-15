/* Load Avro jars and define shortcut */
register /me/Software/pig/build/ivy/lib/Pig/avro-1.5.3.jar
register /me/Software/pig/build/ivy/lib/Pig/json-simple-1.1.jar
register /me/Software/pig/contrib/piggybank/java/piggybank.jar
define AvroStorage org.apache.pig.piggybank.storage.avro.AvroStorage();

register /me/Software/pig-to-json/dist/lib/pig-to-json.jar

-- Enron emails are available at https://s3.amazonaws.com/rjurney_public_web/hadoop/enron.avro
emails = load '/me/Data/enron.avro' using AvroStorage();

json_test = foreach emails generate message_id, com.hortonworks.pig.udf.ToJson(tos) as bag_json;

register /me/Software/pig-redis/dist/pig-redis.jar

store json_test into 'dummy-name' using com.hackdiary.pig.RedisStorer('kv', 'localhost');

/* 

redis 127.0.0.1:6379> get '<765.1075860359973.JavaMail.evans@thyme>'[23360] 15 Feb 13:45:44 - DB 0: 10 keys (0 volatile) in 16 slots HT.
                                                                                                                                        [23360] 15 Feb 13:45:44 - 1 clients connected (0 slaves), 934992 bytes in use

"[{\"address\":\"jay_dudley@pgn.com\",\"name\":null},{\"address\":\"michele_farrell@pgn.com\",\"name\":null}]"

*/
