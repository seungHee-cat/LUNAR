package project.kr.com.config.db;

import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;

import java.util.Properties;

@Intercepts({
		@Signature(type = Executor.class, method = "query", args = {MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class})
})
public class QueryInterceptor implements Interceptor {

    private static final ThreadLocal<String> executedSql = new ThreadLocal<>();

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        // MappedStatement와 파라미터 객체를 추출
        MappedStatement mappedStatement = (MappedStatement) invocation.getArgs()[0];
        Object parameter = invocation.getArgs()[1];
        
        // SQL을 바인딩
        BoundSql boundSql = mappedStatement.getBoundSql(parameter);
        String sql = boundSql.getSql();
        
        // 완성된 쿼리를 저장
        executedSql.set(sql);
        
        // 기존 로직을 계속 실행
        return invocation.proceed();
    }

    @Override
    public Object plugin(Object target) {
        return Plugin.wrap(target, this);
    }

    @Override
    public void setProperties(Properties properties) {
        // 추가 속성 설정
    }

    public static String getExecutedSql() {
        return executedSql.get();
    }

    public static void clear() {
        executedSql.remove();
    }
}