
import React from 'react';
import { FiCopy } from 'react-icons/fi';

export default function CopyToClipboardButton({ content, message }: { content: string, message: string }) {
    const copyTextToClipboard = async () => {
        try {
            await navigator.clipboard.writeText(content);
            alert(message);
        } catch (err) {
            console.error('Failed to copy: ', err);
        }
    };

    return (
        <button onClick={copyTextToClipboard} aria-label="クリップボードにコピー" className='p-2'>
            <FiCopy />
        </button>
    );
};

