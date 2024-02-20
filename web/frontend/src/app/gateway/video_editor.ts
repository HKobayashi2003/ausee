import { atom, useRecoilState } from "recoil";


const loadingState = atom({
    key: 'loadingState',
    default: false,
});

const errorState = atom({
    key: 'errorState',
    default: '',
})

export const useVideoEditor = () => {
    const [ loading, setLoading ] = useRecoilState(loadingState);
    const [error, setError] = useRecoilState(errorState);
    const postUrl = 'http://127.0.0.1:8000'
    
    const postRequest = async (url: string, options: { [key: string]: boolean }) => {
        setLoading(true);
        try {
            const response = await fetch(postUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ url, options }),
            });
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            console.log(response.body)
            setLoading(false);
            return response.json();
        } catch (error: any) {
            setLoading(false);
            setError(error.message);
            console.log(error.message)
        }
    }   

    return {
        loading,
        error,
        postRequest,
    }
}